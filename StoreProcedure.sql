use cob_workflow
go
create procedure consulta_tabla_nombre(
	 @t_show_version BIT = 0, 
	 @i_tipo char(1) = null,
	 @i_tabla varchar(30) = null,
	 @i_codigo varchar(150) = null,
	 @i_oficina int = 1,
	 @i_filas int = 80,
	 @i_descripcion varchar(150) = ''
)
as
begin
	declare @w_sp_name varchar(32)
	select @w_sp_name = 'consulta_tabla_nombre'

	---- VERSIONAMIENTO DEL PROGRAMA ----
	IF @t_show_version = 1
	BEGIN
		 PRINT 'Stored procedure ' + @w_sp_name + ' Version 1.0.0.0'
		 RETURN 
	END
	-------------------------------------
	
	if @i_tipo = 'B'
	begin
		 set rowcount @i_filas
		 select convert(varchar,codigo), nombre from tabla_nombre where nombre > isnull(@i_codigo,'')
		 order by nombre asc
		 set rowcount 0
		 return 
	end

	if @i_tipo = 'V'
	begin
		select nombre from tabla_nombre where codigo = convert(int,@i_codigo)
 
		if @@rowcount = 0 
			raiserror ('No existe dato solicitado', 16, 1)
	end
	
	if @i_tipo = 'S'
	begin
		set rowcount @i_filas
		select convert(varchar, codigo), nombre from tabla_nombre 
		where nombre > isnull(@i_codigo,'') and UPPER(nombre) like '%' + UPPER(@i_descripcion) + '%' 
		order by nombre asc
		set rowcount 0
		return 
	end

	if @i_tipo = 'C'
	begin
		select count(codigo)
		from tabla_nombre
		where UPPER(nombre) like '%' + UPPER(@i_descripcion) + '%'
	end
end
go


