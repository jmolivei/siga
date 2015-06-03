<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>

<siga:pagina titulo="Justi�a Federal" desabilitarbusca="sim" incluirJs="siga/javascript/jquery.placeholder.js">

	<script type="text/javascript">
		function salvarUsuario(matricula){
			localStorage.setItem("matricula", matricula);
		}
	
		/*  converte para mai�scula a sigla do estado  */
		function converteUsuario(nomeusuario) {
			re = /^[a-zA-Z]{2}\d{3,6}$/;
			ret2 = /^[a-zA-Z]{1}\d{3,6}$/;
			tmp = nomeusuario.value;
			if (tmp.match(re) || tmp.match(ret2)) {
				nomeusuario.value = tmp.toUpperCase();
			}

			salvarUsuario(nomeusuario.value);
		}
	</script>

	<c:set var="pagina" scope="session">${pageContext.request.requestURL}</c:set>

	<div class="gt-bd gt-cols clearfix">

		<!-- main content -->
		<div id="gc-ancora" class="gt-content">
			<c:import url="comentario.jsp" />
			<h4>Vers�o: ${siga.versao} </h4>
		</div>
		<!-- / main content -->

		<!-- sidebar -->
		<div class="gt-sidebar">
			<!-- login form head -->
			<div class="gt-mylogin-hd">Identifica��o</div>

			<!-- login box -->
			<div class="gt-mylogin-box">
				<!-- login form -->
				<form method="post" action="j_security_check" enctype="application/x-www-form-urlencoded" class="gt-form">
					<!-- form row -->
					<div class="gt-form-row">
						<label class="gt-label">Matr�cula</label>
						<input id="j_username" type="text" name="j_username" placeholder="XX99999"
							onblur="javascript:converteUsuario(this)" class="gt-form-text">
					</div>
					<!-- /form row -->

					<!-- form row -->
					<div class="gt-form-row">
						<label class="gt-label">Senha</label>
						<input type="password" name="j_password" class="gt-form-text">
					</div>
					<!-- /form row -->

					<!-- form row -->
					<div class="gt-form-row">
						<input type="submit" value="Acessar" class="gt-btn-medium gt-btn-right">
					</div>
					<!-- /form row -->

					<p class="gt-forgot-password">
						<a href="/siga/usuario/incluir_usuario.action">Sou um novo usu�rio</a>
					</p>
					<p class="gt-forgot-password">
						<a href="/siga/usuario/esqueci_senha.action">Esqueci minha senha</a>
					</p>
				</form>
				<!-- /login form -->
			</div>
			<!-- /login box -->

			<!-- Sidebar Navigation -->
			<div class="gt-sidebar-nav gt-sidebar-nav-blue">
				<h3>Links �teis</h3>
				<ul>
					<li><a href="/siga/arquivos/apostila_sigaex.pdf">Apostila SIGA-Doc</a></li>
					<li><a href="/siga/arquivos/apostila_sigawf.pdf">Apostila SIGA-Workflow</a></li>
				</ul>
			</div>
			<!-- /Sidebar Navigation -->
			<!-- Sidebar Content -->
		</div>
		<!-- / sidebar -->
	</div>
    <script type="text/javascript">
        $('input, textarea').placeholder();
        $("#j_username").focus();

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i=0; i<ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0)==' ') c = c.substring(1);
                if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
            }
            return "";
        }

        var idp = getCookie("JSESSIONID").replace(/"/g,"");
        if (idp != null && idp != "undefined")
        	localStorage.setItem("idp", idp);

    </script>
</siga:pagina>
