<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>
<style>
	.valor {
      display:none;
    }
</style>
<c:set var="etapas" value="${solicitacao.getEtapas(lotaTitular)}" />
<c:if test="${not empty etapas}">
<c:forEach var="etapa" items="${etapas}">
<div class="gt-sidebar">
	<div class="gt-sidebar-content cronometro ${etapa.ativo ? 'ligado' : 'desligado'}">
		<h3>
			<img src="/siga/css/famfamfam/icons/clock.png" width="15px;"
				style="vertical-align: bottom;">&nbsp;${etapa.descricaoComLotaResponsavel}
		</h3>
		<c:if test="${not empty etapa.inicio}">
		    <p><b>In&iacute;cio: </b>${etapa.inicioString}</p>
		</c:if>
		<c:choose>
			<c:when test="${not empty etapa.fim}">
				<p><b>Fim:</b> ${etapa.fimString}</p>
			</c:when>
			<c:when test="${not empty etapa.fimPrevisto}">
				<p><b>Previs&atilde;o:</b> ${etapa.fimPrevistoString}
			</c:when>
		</c:choose>
		<c:set var="restante" value="${etapa.restanteEmSegundos}" />
		<c:choose>
			<c:when test="${not empty restante}">
				<p><span class="crono restante ${etapa.ativo ? 'ligado' : 'desligado'}"><b><span class="label"></span></b><span class="descrValor"></span><span class="valor">${restante}</span></span></p>
			</c:when>
			<c:otherwise>
				<p><span class="crono decorrido ${etapa.ativo ? 'ligado' : 'desligado'}"><b>Decorrido:</b> <span class="descrValor"></span><span class="valor">${etapa.decorridoEmSegundos}</span></span></p>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</c:forEach>
</c:if>