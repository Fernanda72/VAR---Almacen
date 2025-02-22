<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Consultar Cuadro de Requerimientos</title>
<%@ include file="Snippets/BooststrapEstyles.jsp"%>
<link href="Estyles/ConsultarCuadroNec.css" rel="stylesheet">
</head>
<style>
	.tbodyDiv{
	max-height: clamp(45vh,10vh,250px);
	overflow: auto;
}
</style>
<body>
	<%@ include file="Snippets/Encabezado.jsp" %>
	<div class="dashboard_content">
		<%@ include file="Snippets/MenuLateral.jsp" %>
		<section class="consultaRequ" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" >
			<center><h3>CONSULTAR CUADRO DE REQUERIMIENTOS</h3></center>
			<span class="fw-bold fs-5 text-danger">${sessionScope.UNIDAD_ORGANICA}</span>
			<div class="consultaRequ__block_query">
				<form id="idConsultar" method="post" action="" class="consultaRequ__criterios consultaRequ__criterios_unidadOrganica" role="form">
					<div class="form-group">
					    <label for="exampleInputEmail1" class="form-label">Destinatario</label>
					    <input type="text" class="form-control" name="destinatario" id="idDestinatarioCriterio">
					</div>
					<div class="form-group">
					    <label for="exampleInputEmail1" class="form-label">Fecha</label>
					    <input type="date" class="form-control" name="fecha" id="idFecha">
					</div>
					<div class="form-group">
					    <label for="exampleInputPassword1" class="form-label">Estado</label>
					   <select class="form-select"  name="estado" id="idEstado">
					   	  <option value="">Seleccione un Estado</option>
					   	  <option value="PENDIENTE">PENDIENTE</option>
					   	  <option value="APROBADO">APROBADO</option>
					   	  <option value="RECHAZADO">RECHAZADO</option>
					   	  <option value="FORMULADO">FORMULADO</option>				   	
						</select>
					 </div>
					 <div class="form-group">
					    <label for="exampleInputEmail1" class="form-label">Cantidad</label>
					    <input type="number" class="form-control" name="cantidad" id="idCantidad" value=0>
					 </div>
					 <button type="button" class="btn btn-danger btn__fontSize" id="btnConsultar">Consultar</button>
				 </form>
			</div>
			<div class="consultaRequ__block_table">
				<div class="mt-3 tbodyDiv">
				<table id="tbreq" class="table table-bordered table-striped text-center" style="width:100%">
			        <thead class="table-danger sticky-top bg-white">
			            <tr>
			                <th>NRO</th>
			                <th>RESPONSABLE</th>
			                <th>DESTINATARIO</th>
			                <th>UNIDAD ORGANICA</th>
			                <th>CANTIDAD</th>
			                <th>FECHA</th>
			                <th></th>
			            </tr>
			        </thead>
			        <tbody>
				    </tbody>
		    	</table>		
			</div>
			<div class="consultaRequ__block_info mt-2"><p id="idContador"></p></div>			
		</div>
		<%@ include file="Snippets/ModalDetalleReq.jsp" %>	
		</section>
	</div>
<%@ include file="Snippets/BooststrapJS.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		$('#nav01').removeClass("active");
		$('#nav14').removeClass("active");
		$('#nav15').addClass("active");
		$('#nav16').removeClass("active");
		//$('#example').DataTable();
		$('#idConsultar').bootstrapValidator({
			fields:{
				destinatario:{
					validators:{
						regexp:{
    			 			regexp:/^[A-Za-z\�\�\�\�\�\�\�\�\�\�\�\�\s]{3,30}$/,
    			 			message:'Solo letras | Campo de 30 caracteres'
    			 		}
					}
				},
				cantidad:{
					validators:{
						between:{
							min:1,
    		 				max:9999,
    		 				message:'Solo n�meros | Maximo 9999'
    			 		}
					}
				}
			}
		})
	});
	
	$(document).on("click","#btnConsultar",function(){
		let dest,fecha,estado,cant, count = 0;
		dest = $("#idDestinatarioCriterio").val();
		fecha = $("#idFecha").val();
		estado = $("#idEstado").val();
		cant = $("#idCantidad").val();		
		$("#tbreq tbody").empty();
		$("#idContador").empty();
		$.get("ServletRequerimientoJSON?accion=CONSULTARAC&dest="+dest+"&fecha="+fecha+"&estado="+estado+"&cant="+cant, function(response){
			$.each(response,function(index,item){
				$("#tbreq").append("<tr><td>"+item.numreq+"</td><td>"+item.apenomSoli+
												"</td><td>"+item.apenomEntre+
												"</td><td>"+item.nomUniEntr+ 
												"</td><td>"+item.cantidad+
												"</td><td>"+item.fechaEmi+
												"</td></tr>");
				count++;
			})
			$("#idContador").text(count+" Cuadro de Requerimiento encontradas")
		})
	})	
</script>

</body>
</html>