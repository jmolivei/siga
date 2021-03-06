<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de ISEN��O DO IMPOSTO DE RENDA PARA APOSENTADO   -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>	
		<mod:grupo titulo="DETALHES DO APOSENTADO">
				<mod:texto titulo="Nome do Servidor Inativo" var="nomeServidorInativo" largura="60" />
				<mod:grupo>
					<mod:texto titulo="Endere�o" var="endereco" largura="70" />
				</mod:grupo>
				<mod:grupo>
				<mod:texto titulo="Telefone (1)" var="tel1" largura="15" maxcaracteres="11"/>
				<mod:texto titulo="Telefone (2)" var="tel2" largura="15" maxcaracteres="11"/>
				</mod:grupo>
		</mod:grupo>		
	</mod:entrevista>
			
	<mod:documento>
	
		<mod:valor var="texto_requerimento">	
		<p style="TEXT-INDENT: 2cm" align="justify">
		<b>${nomeServidorInativo}</b>, servidor(a) Inativo(a) desta <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise></c:choose>, residente na <b>${endereco}</b>, 
				
		<c:if test="${tel1!='' && tel2!=''}">
		telefone(s) para contato  
		</c:if>
		
		<c:if test="${tel1!='' && tel2==''}">
		telefone como contato 
		</c:if>

		<c:if test="${tel1!=''}">
		<b>${tel1}</b>, 
		</c:if>

		<c:if test="${tel2!=''}">
		e <b>${tel2}</b>, 
		</c:if>
		
		vem requerer a Vossa Excel�ncia <b>ISEN��O DE IMPOSTO 
		DE RENDA</b>, com base nas Leis n&ordm; 7.713/88 e 9.250/95, 
		regulamentadas pelo Decreto n&ordm; 3.000/99 e conforme disposto 
		na Instru��o Normativa SRF n&ordm; 15/2001, bem como a aplica��o 
		da <b>FORMA DIFERENCIADA DE CONTRIBUI��O PREVIDENCI�RIA</b>, prevista no 
		art. 40, � 21, da Constitui��o Federal, inclu�do pela Emenda Constitucional 
		n� 47/2005, em face da patologia que lhe acometeu.
		</p><br>
						
		</mod:valor>		
	
</mod:documento>
</mod:modelo>
