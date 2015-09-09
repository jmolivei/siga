<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>

<siga:pagina titulo="${solicitacao.codigo}">
	<jsp:include page="../main.jsp"></jsp:include>

	<script src="/sigasr/javascripts/jquery.dataTables.min.js"></script>
	<script src="/sigasr/javascripts/jquery.serializejson.min.js"></script>
	<script src="/sigasr/javascripts/jquery.populate.js"></script>
	<script src="/sigasr/javascripts/jquery.maskedinput.min.js"></script>
	<script src="/sigasr/javascripts/base-service.js"></script>
	<script src="/sigasr/javascripts/jquery.validate.min.js"></script>
	<script src="/sigasr/javascripts/detalhe-tabela.js"></script>
	<script src="/sigasr/javascripts/cronometro.js"></script>
	<script src="/sigasr/javascripts/language/messages_pt_BR.min.js"></script>

	<style>
		ul.lista-historico li span {
			text-decoration: line-through;
		}
		
		ul.lista-historico li {
			list-style: none;
		}
		
		ul.lista-historico li.unico {
			margin-left: 0px !important;
		}
		
		button.button-historico {
			padding-left: 2px;
			padding-right: 2px;
			width: 16px;
		}
		
		.historico-label {
			font-weight: bold;
			margin-right: 4px;
		}
		
		.hidden {
			display: none;
		}
	</style>

	<div class="gt-bd gt-cols clearfix" style="padding-bottom: 0px;">
		<div class="gt-content clearfix">
			<h2>${solicitacao.codigo}</h2>
			<p></p>
			<h3>
				${solicitacao.getMarcadoresEmHtml(titular, lotaTitular)}
				<c:if test="${solicitacao.solicitacaoPrincipal != null}"> -
                <a style="text-decoration: none"
						href="${linkTo[SolicitacaoController].exibir[solicitacao.solicitacaoPrincipal.idSolicitacao]}">
						${solicitacao.solicitacaoPrincipal.codigo} </a>
				</c:if>
			</h3>

			<siga:linkSr acoes="${solicitacao.operacoes(titular, lotaTitular)}" />
			<div class="gt-content-box" style="padding: 10px">
				<p style="font-size: 11pt; font-weight: bold; color: #365b6d;">
					<siga:descricaoItem itemConfiguracao="${solicitacao.itemAtual}" />
					-
					<siga:descricaoAcao acao="${solicitacao.acaoAtual}" />
				</p>
				<p id="descrSolicitacao" style="font-size: 9pt;">${solicitacao.descricao}</p>
				<script language="javascript">
					var descricao = document.getElementById('descrSolicitacao');
					descricao.innerHTML = descricao.innerHTML.replace(/\n\r?/g,
							'<br />');
				</script>
				<c:forEach items="${solicitacao.atributoSolicitacaoSet}" var="att">
					<c:if
						test="${att.valorAtributoSolicitacao != null && !att.valorAtributoSolicitacao.isEmpty()}">
						<p style="font-size: 9pt; padding: 0px">
							<b>${att.atributo.nomeAtributo}:</b>
							${att.valorAtributoSolicitacao}
						</p>
					</c:if>
				</c:forEach>
			</div>

			<br /> <br />
			<div class="gt-content-box gt-form"
				style="margin-bottom: 0px !important">
				<form action="${linkTo[SolicitacaoController].darAndamento}"
					method="post" onsubmit="javascript: return block();"
					enctype="multipart/form-data">
					<input type="hidden" name="todoOContexto" value="${todoOContexto}" />
					<input type="hidden" name="ocultas" value="${ocultas}" /> <input
						type="hidden" name="movimentacao.solicitacao.idSolicitacao"
						value="${movimentacao.solicitacao.idSolicitacao}" />

					<c:choose>
						<c:when test="${solicitacao.podeTrocarAtendente(titular, lotaTitular)}">
							<div class="gt-form-row">
								<label>Atendente</label>
								<div id="divAtendente">
									<select name="movimentacao.atendente.id" id="selectActendente">
	            						<option value=""></option>
										<c:if test="${atendentes.size() >= 1}">
											<c:forEach items="${atendentes}" var="pessoa">
												<option value="${pessoa.pessoaAtual.idPessoa}" ${movimentacao.atendente.idInicial.equals(pessoa.idInicial) ? 'selected' : ''}>${pessoa.pessoaAtual.descricaoIniciaisMaiusculas}</option>
											</c:forEach>
										</c:if>
										<c:set var="substitutos" value="${solicitacao.substitutos}" />
										<c:if test="${substitutos.size() >= 1}">
											<optgroup label="Substitutos">
												<c:forEach items="${substitutos}" var="pessoaSubst">
													<option value="${pessoaSubst.substituto.pessoaAtual.idPessoa}">${pessoaSubst.substituto.pessoaAtual.descricaoIniciaisMaiusculas}</option>
												</c:forEach>
											</optgroup>
										</c:if>
									</select>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="movimentacao.atendente.id" value="${movimentacao.solicitacao.atendente.pessoaAtual.idPessoa}" />
						</c:otherwise>
					</c:choose>
					<div style="display: inline" class="gt-form-row gt-width-66">
						<label>Pr&oacute;ximo Andamento</label>
						<textarea style="width: 100%"
							name="movimentacao.descrMovimentacao" id="descrSolicitacao"
							cols="70" rows="4" value="${movimentacao.descrMovimentacao}"></textarea>
					</div>

					<div class="gt-form-row">
						<input type="submit" value="Gravar"
							class="gt-btn-medium gt-btn-left" />
					</div>
				</form>
			</div>
			<p style="padding-top: 30px; font-weight: bold; color: #365b6d;">
				<c:if test="${solicitacao.estaSendoAtendidaPor(titular, lotaTitular) || exibirMenuAdministrar}">
					<input type="radio" name="exibirEtapas" value="false" id="radioMovs" onclick="exibirMovs();" />&nbsp;Movimenta&ccedil;&otilde;es&nbsp;
					<input type="radio" name="exibirEtapas" value="true" id="radioEtapas" onclick="exibirEtapas();" />&nbsp;Atendimentos&nbsp;&nbsp;
				</c:if>
				<span id="todoOContexto">
					<c:if test="${solicitacao.parteDeArvore}">
						<siga:checkbox name="todoOContexto" value="${todoOContexto}" onchange="postback();"></siga:checkbox> Todo o Contexto
                    	&nbsp;&nbsp;
           			</c:if>
           		</span>
				<span id="maisDetalhes"><siga:checkbox name="ocultas" value="${ocultas}" onchange="postback();"></siga:checkbox>
				Mais Detalhes</span>
			</p>
			<div class="gt-content-box" id="movs">
				<table border="0" width="100%" class="gt-table mov">
					<thead>
						<tr>
							<th>Momento</th>
							<c:if test="${todoOContexto}">
								<th>Solicita&ccedil;&atilde;o</th>
							</c:if>
							<th>Evento</th>
							<th colspan="2">Cadastrante</th>
							<th colspan="2">Atendente</th>
							<th>Descri&ccedil;&atilde;o</th>
						</tr>
					</thead>

					<tbody>
						<c:choose>
							<c:when test="${movs != null && !movs.isEmpty()}">
								<c:forEach items="${movs}" var="movimentacao">
									<tr <c:if test="${movimentacao.canceladoOuCancelador}"> class="disabled" </c:if>>
										<c:choose>
											<c:when test="${ocultas}">
												<td>${movimentacao.dtIniMovDDMMYYHHMM}</td>
											</c:when>
											<c:otherwise>
												<td>${movimentacao.dtIniString}</td>
											</c:otherwise>
										</c:choose>

										<c:if test="${todoOContexto}">
											<td>
											     <c:if test="${movimentacao.solicitacao.filha}">
												     <a style="color: #365b6d;" 
												        href="${linkTo[SolicitacaoController].exibir[movimentacao.solicitacao.idSolicitacao]}" 
												        style="text-decoration: none">
														${movimentacao.solicitacao.numSequenciaString} </a>
											     </c:if>
											</td>
										</c:if>
										<td>${movimentacao.tipoMov.nome}</td>
										<td><siga:selecionado
												sigla="${movimentacao.lotaCadastrante.siglaLotacao}"
												descricao="${movimentacao.lotaCadastrante.nomeLotacao}"></siga:selecionado>
										</td>
										<td><siga:selecionado
												sigla="${movimentacao.cadastrante.nomeAbreviado}"
												descricao="${movimentacao.cadastrante.descricaoIniciaisMaiusculas}"></siga:selecionado>
										</td>
										<td><siga:selecionado
												sigla="${movimentacao.lotaAtendente.siglaLotacao}"
												descricao="${movimentacao.lotaAtendente.nomeLotacao}"></siga:selecionado>
										</td>
										<td><siga:selecionado
												sigla="${movimentacao.atendente.nomeAbreviado}"
												descricao="${movimentacao.atendente.descricaoIniciaisMaiusculas}"></siga:selecionado>
										</td>
										<td id="descrMovimentacao${movimentacao.idMovimentacao}">
										    <span id="descrMovimentacaoTexto${movimentacao.idMovimentacao}">${movimentacao.descrMovimentacao}</span>
											<c:if test="${movimentacao.arquivo != null}">
												&nbsp;|&nbsp;
                                        		<siga:arquivo arquivo="${movimentacao.arquivo}" />
											</c:if>
											<c:if test="${movimentacao.tipoMov.idTipoMov == 16}">
												<c:forEach items="${movimentacao.respostaSet}" var="resposta">
													<c:if test="${resposta.pergunta.tipoPergunta.idTipoPergunta == 1}">
														<b>- ${resposta.pergunta.descrPergunta}:</b> ${resposta.descrResposta}
                                                    </c:if>
													<c:if test="${resposta.pergunta.tipoPergunta.idTipoPergunta == 2}">
														<b>- ${resposta.pergunta.descrPergunta}:</b> ${resposta.grauSatisfacao}
                                                    </c:if>
												</c:forEach>
											</c:if>
										</td>
										<script language="javascript">
											var descricao = document.getElementById('descrMovimentacaoTexto${movimentacao.idMovimentacao}');
											descricao.innerHTML = descricao.innerHTML.replace(/\n\r?/g, '<br />');
										</script>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td align="center" colspan="10">N&atilde;o h&aacute;
										movimenta&ccedil;&otilde;es nesse modo de
										exibi&ccedil;&atilde;o</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="gt-content-box" id="etapas">
				<table border="0" width="100%" class="gt-table mov">
					<thead>
						<tr>
							<th>Etapa</th>
							<th>Equipe</th>
							<th>Início</th>
							<th>Fim</th>
							<th>Decorrido</th>
							<th>Restante</th>
							<th>Acordo</th>
						</tr>
					</thead>

					<tbody>
						<c:set var="etapas" value="${solicitacao.etapas}" />
						<c:choose>
							<c:when test="${not empty etapas}">
								<c:forEach items="${etapas}" var="etapa">
									<tr>
										<td>${etapa.descricao}</td>
										<td>${not empty etapa.lotaResponsavel ? etapa.lotaResponsavel : ''}</td>
										<td>${etapa.inicioString}</td>
										<td>${etapa.fimString}</td>
										<td class="crono resumido decorrido ${etapa.ativo ? 'ligado' : 'desligado'}">
											<nobr><span class="descrValor"></span><span class="valor">${etapa.decorridoEmSegundos}</span></nobr>
										</td>
										<td class="crono resumido restante ${etapa.ativo ? 'ligado' : 'desligado'}">
											<nobr><span class="descrValor"></span><span class="valor">${etapa.restanteEmSegundos}</span></nobr>
										</td>
										<td><c:if test="${not empty etapa.paramAcordo}">${etapa.paramAcordo.acordo.nomeAcordo}</c:if></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td align="center" colspan="10">N&atilde;o h&aacute;
										atendimentos nesse modo de
										exibi&ccedil;&atilde;o</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<script>
				function exibirMovs(){
					$("#movs").show();
					$("#maisDetalhes").show();
					$("#todoOContexto").show();
					$("#etapas").hide();
				}
				function exibirEtapas(){
					$("#etapas").show();
					$("#movs").hide();
					$("#maisDetalhes").hide();
					$("#todoOContexto").show();
				}
				$("#radioMovs").trigger("click");
			</script>
		</div>

		<jsp:include page="exibirCronometro.jsp"></jsp:include>
		<jsp:include page="exibirPendencias.jsp"></jsp:include>
		<div class="gt-sidebar">
			<div class="gt-sidebar-content">
				<h3>Solicita&ccedil;&atilde;o</h3>
				<p>
					<b>Solicitante:</b>
					${solicitacao.solicitante.descricaoIniciaisMaiusculas},
					${solicitacao.lotaSolicitante.siglaLotacao},
                    ${solicitacao.local.nomeComplexo}
				</p>
				<c:if test="${solicitacao.interlocutor != null}">
					<p>
						<b>Interlocutor:</b>
						${solicitacao.interlocutor.descricaoIniciaisMaiusculas}
					</p>
				</c:if>
				<c:if test="${solicitacao.dtOrigem != null}">
					<p>
						<b>Contato Inicial:</b> ${solicitacao.dtOrigemString}
						<c:if test="${solicitacao.meioComunicacao != null}">
                        por ${solicitacao.meioComunicacao.descrMeioComunicacao}
                    </c:if>
					</p>
				</c:if>
				<c:if test="${solicitacao.meioComunicacao != null}">
					<p>
						<b>Origem da Demanda:</b>
						${solicitacao.meioComunicacao.descrMeioComunicacao}
					</p>
				</c:if>
				<c:if test="${solicitacao.telPrincipal != null}">
					<p>
						<b>Telefone:</b> ${solicitacao.telPrincipal}
					</p>
				</c:if>
				<p>
					<b>Cadastrante:</b>
					${solicitacao.cadastrante.descricaoIniciaisMaiusculas},
					${solicitacao.lotaTitular.siglaLotacao}
				</p>
				<c:if test="${solicitacao.isEscalonada()}">
					<c:set var="itemEscalonar"
						value="${solicitacao.getItemAtual().toString()}" />
					<c:set var="acaoEscalonar"
						value="${solicitacao.getAcaoAtual().toString()}" />
				</c:if>
				<p>
					<span class="historico-label">Item de Configura&ccedil;&atilde;o:</span>
				<div class="historico-item-container hidden">
					<button type="button" class="button-historico"
						title="Clique para abrir/fechar o histórico">+</button>

					<ul class="lista-historico historico-item">
						<c:forEach items="${solicitacao.historicoItem}" var="item">
							<li><span>${item.sigla} - ${item.descricao}</span></li>
						</c:forEach>
					</ul>
				</div>
				</p>
				<p>
					<span class="historico-label">A&ccedil;&atilde;o:</span>
				<div class="historico-acao-container hidden">
					<button type="button" class="button-historico"
						title="Clique para abrir/fechar o histórico">+</button>

					<ul class="lista-historico historico-acao">
						<c:forEach items="${solicitacao.historicoAcao}" var="acao">
							<li><span>${acao.siglaAcao} - ${acao.descricao}</span></li>
						</c:forEach>
					</ul>
				</div>
				</p>
				<p>
					<b>Prioridade:</b> <span style="">${solicitacao.prioridade.descPrioridade}</span>
				</p>
				<c:if test="${solicitacao.prioridadeTecnica != solicitacao.prioridade}">
					<p>
						<b>Prioridade T&eacute;cnica:</b> <span style="">${solicitacao.prioridadeTecnica.descPrioridade}</span>
					</p>
				</c:if>
				<p>
					<b>Notifica&ccedil;&atilde;o:</b>
					${solicitacao.formaAcompanhamento.descrFormaAcompanhamento}
				</p>
				<c:if
					test="${solicitacao.isFechadoAutomaticamente() != null && solicitacao.isPai()}">
					<p>
						<b>Fechamento Autom&aacute;tico:</b>
						${solicitacao.isFechadoAutomaticamente() ? "Sim" : "Não"}
					</p>
				</c:if>
			</div>
		</div>

		<c:set var="vinculadas"	value="${solicitacao.solicitacoesVinculadas}" />
		<c:if test="${vinculadas != null && !vinculadas.isEmpty()}">
			<div class="gt-sidebar">
				<div class="gt-sidebar-content">
					<h3>Veja Tamb&eacute;m</h3>
					<p>
						<c:forEach items="${vinculadas}" var="vinculada">
							<a
								href="${linkTo[SolicitacaoController].exibir[vinculada.idSolicitacao]}">
								${vinculada.codigo} </a>
							<br />
						</c:forEach>
					</p>
				</div>
			</div>
		</c:if>
		<c:if test="${solicitacao.parteDeArvore}">
			<div class="gt-sidebar">
				<div class="gt-sidebar-content">
					<h3>Contexto</h3>
					<p>
						<siga:listaArvore solicitacao="${solicitacao.paiDaArvore}"
							visualizando="${solicitacao}" />
					</p>
				</div>
			</div>
		</c:if>
		<c:if test="${solicitacao.temArquivosAnexos()}">
			<div class="gt-sidebar">
				<div class="gt-sidebar-content">
					<h3>Arquivos Anexos</h3>
					<p>
						<siga:arquivo arquivo="${solicitacao.arquivoAnexoNaCriacao}" />
						<br />
						<c:forEach items="${solicitacao.movimentacoesAnexacao}" var="anexacao">
							<siga:arquivo arquivo="${anexacao.arquivo}" /> 
							&nbsp;-&nbsp;${anexacao.descrMovimentacao}<br />
                    	</c:forEach>
                	</p>
	            </div>
	        </div>
	    </c:if>
	
	    <c:set var="juntadas" value="${solicitacao.solicitacoesJuntadas}"/>
	    <c:if test="${juntadas != null && !juntadas.isEmpty()}">
	        <div class="gt-sidebar">
	            <div class="gt-sidebar-content">
	                <h3>Solicita&ccedil;&otilde;es juntadas</h3>
	                <p>
	                    <c:forEach items="${juntadas}" var="juntada">
	                        <a href="${linkTo[SolicitacaoController].exibir[juntada.idSolicitacao]}">
	                        ${juntada.codigo} </a> <br/> 
	                    </c:forEach>
	                </p>
	            </div>
	        </div>
	    </c:if>
	    <c:if test="${solicitacao.emLista}">
	        <div class="gt-sidebar">
	            <div class="gt-sidebar-content">
	                <h3>Listas de Prioridade</h3>
	                    <ul>
	                    <c:forEach items="${solicitacao.listasAssociadas}" var="listas">
	                        <li>
	                            &nbsp; <input type="hidden" name="idlista"
	                            value="${listas.idLista}"> <a
	                            style="color: #365b6d; text-decoration: none"
	                            href="${linkTo[SolicitacaoController].exibirLista[listas.idLista]}">
	                                ${listas.listaAtual.nomeLista} </a>
	                        </li>
	                    </c:forEach>
	                    </ul>
	            </div>
	        </div>
	    </c:if>
  
	    <div id="divConhecimentosRelacionados">
	        <jsp:include page="exibirConhecimentosRelacionados.jsp"></jsp:include>
	    </div>
    
    <siga:modal nome="anexarArquivo" titulo="Anexar Arquivo">
        <div class="gt-content-box gt-form">
            <form action="${linkTo[SolicitacaoController].anexarArquivo}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">               
                <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
                <input type="hidden" name="ocultas" value="${ocultas}" />
                <input type="hidden" name="movimentacao.solicitacao.idSolicitacao"
                    value="${solicitacao.idSolicitacao}"> <input
                    type="hidden" name="movimentacao.tipoMov.idTipoMov" value="12">
                <div class="gt-form-row">
                    <label>Arquivo</label> <input type="file" name="movimentacao.arquivo">
                </div>
                <div style="display: inline" class="gt-form-row gt-width-66">
                    <label>Descri&ccedil;&atilde;o</label>
                    <textarea style="width: 100%" name="movimentacao.descrMovimentacao"
                        id="descrSolicitacao" cols="70" rows="4"
                        value="${movimentacao.descrMovimentacao}"></textarea>
                </div>
                <div class="gt-form-row">
                    <input type="submit" value="Gravar"
                        class="gt-btn-medium gt-btn-left" />
                </div>
            </form>
        </div>
    </siga:modal> 
    <siga:modal nome="fechar" titulo="Fechar">
        <form action="${linkTo[SolicitacaoController].fechar}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">
            <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
            <input type="hidden" name="ocultas" value="${ocultas}" />
            <div style="display: inline" class="gt-form-row gt-width-66">
                <label>Motivo</label>
                <textarea style="width: 100%" name="motivo" cols="50" rows="4"> </textarea>
            </div>
            <input type="hidden" name="id" value="${solicitacao.idSolicitacao}" /> <input
                type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
        </form>
    </siga:modal>
    
    <siga:modal nome="incluirEmLista" titulo="Definir Lista" url="${linkTo[SolicitacaoController].incluirEmLista}?id=${solicitacao.idSolicitacao}" />
    
    <siga:modal nome="escalonar" titulo="Escalonar Solicitação" url="${linkTo[SolicitacaoController].escalonar}?id=${solicitacao.idSolicitacao}" />

    <siga:modal nome="juntar" titulo="Juntar">
        <form action="${linkTo[SolicitacaoController].juntar}" method="post" enctype="multipart/form-data" id="formGravarJuncao">
            <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
            <input type="hidden" name="ocultas" value="${ocultas}" />
            <input type="hidden" name="idSolicitacaoAJuntar" value="${solicitacao.idSolicitacao}"> 
            <div style="display: inline; padding-top: 10px;" class="gt-form-row gt-width-66">
                <label>Solicita&ccedil;&atilde;o</label> <br />
                <siga:selecao2 propriedade="solRecebeJuntada" tipo="solicitacao" tema="simple" modulo="sigasr" onchange="validarAssociacao('Juncao');"
                	tamanho="grande"/>
                <span id="erroSolicitacaoJuncao" style="color: red; display: none;">Solicita&ccedil;&atilde;o n&atilde;o informada.</span>
            </div>
            <div class="gt-form-row gt-width-100" style="padding: 10px 0;">
                <label>Justificativa</label>
                <textarea style="width: 100%;" cols="70" rows="4" name="justificativa" id="justificativaJuncao" maxlength="255" onkeyup="validarAssociacao('Juncao')"></textarea>
                <span id="erroJustificativaJuncao" style="color: red; display: none;"><br />Justificativa n&atilde;o informada.</span>
            </div>
            <div style="display: inline" class="gt-form-row ">
                <input type="button" onclick="gravarAssociacao('Juncao');" value="Gravar" class="gt-btn-medium gt-btn-left" />
            </div>
        </form>
    </siga:modal>
    <siga:modal nome="vincular" titulo="Vincular">
        <form action="${linkTo[SolicitacaoController].vincular}" method="post" enctype="multipart/form-data" id="formGravarVinculo">
            <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
            <input type="hidden" name="ocultas" value="${ocultas}" />
            <input type="hidden" name="idSolicitacaoAVincular" value="${solicitacao.idSolicitacao}"> 
            <div style="display: inline; padding-top: 10px;" class="gt-form-row gt-width-66">
                <label>Solicita&ccedil;&atilde;o</label> <br />
                <siga:selecao2 propriedade="solRecebeVinculo" tipo="solicitacao" tema="simple" modulo="sigasr" onchange="validarAssociacao('Vinculo');"
                	tamanho="grande"/>
                <span id="erroSolicitacaoVinculo" style="color: red; display: none;">Solicita&ccedil;&atilde;o n&atilde;o informada.</span>
            </div>
            <div class="gt-form-row gt-width-100" style="padding: 10px 0;">
                <label>Justificativa</label>
                <textarea style="width: 100%;" cols="70" rows="4" name="justificativa" id="justificativaVinculo" maxlength="255" onkeyup="validarAssociacao('Vinculo')"></textarea>
                <span id="erroJustificativaVinculo" style="color: red; display: none;"><br />Justificativa n&atilde;o informada.</span>
            </div>
            <div style="display: inline" class="gt-form-row ">
                <input type="button" onclick="gravarAssociacao('Vinculo');" value="Gravar" class="gt-btn-medium gt-btn-left" />
            </div>
        </form>
    </siga:modal>

    <siga:modal nome="associarLista" titulo="Definir Lista" url="associarLista.jsp" />

    <siga:modal nome="responderPesquisa" titulo="Responder Pesquisa" url="responderPesquisa?id=${solicitacao.id}" />

    <siga:modal nome="deixarPendente" titulo="Pendência">
            <div class="gt-content-box gt-form clearfix">
                <form action="${linkTo[SolicitacaoController].deixarPendente}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">
                    <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
                    <input type="hidden" name="ocultas" value="${ocultas}" />
                    <div class="gt-form-row gt-width-66">
                        <label>Data de T&eacute;rmino</label>
                        <siga:dataCalendar nome="calendario" id="calendario"/>
                    </div>
                    <div class="gt-form-row gt-width-66">
                        <label>Hor&aacute;rio de T&eacute;rmino</label>
                        <input type="text" name="horario" id="horario">
                    </div>
                    <div class="gt-form-row gt-width-66">
                        <label>Motivo</label>
                        <siga:select name="motivo" id="motivo" list="motivosPendencia"
	                            listValue="descrTipoMotivoPendencia" theme="simple" isEnum="true"/>
                    </div>
                    <div class="gt-form-row gt-width-66">
                        <label>Detalhamento do Motivo</label>
                        <textarea name="detalheMotivo" cols="50" rows="4"> </textarea>
                    </div>
                    <div class="gt-form-row">
                        <input type="hidden" name="id" value="${solicitacao.id}" /> <input
                            type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
                    </div>
                </form>
            </div>
    </siga:modal> 
    <siga:modal nome="alterarPrioridade" titulo="Alterar Prioridade">
        <div class="gt-form gt-content-box">
            <form action="${linkTo[SolicitacaoController].alterarPrioridade}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">
                <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
                <input type="hidden" name="ocultas" value="${ocultas}" />
                <div class="gt-form-row gt-width-33">
					<label>Prioridade</label> 
					<siga:select name="prioridade" id="prioridade" list="prioridadeList" listValue="descPrioridade" listKey="idPrioridade" isEnum="true"
							value="${solicitacao.prioridadeTecnica}" 
							style="width:235px"  />
 				</div>
                <div class="gt-form-row">
                	<input type="hidden" name="id" value="${solicitacao.id}" /> 
                	<input type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
                </div>
            </form>
        </div>
    </siga:modal>
    <siga:modal nome="desentranhar" titulo="Desentranhar">
        <form action="${linkTo[SolicitacaoController].desentranhar}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">
            <div style="display: inline" class="gt-form-row gt-width-66">
                <label>Justificativa</label>
                <textarea style="width: 100%" name="justificativa" cols="50" rows="4"> </textarea>
            </div>
            <input type="hidden" name="completo" value="${completo}" /> <input
                type="hidden" name="id" value="${solicitacao.id}" /> <input
                type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
        </form>
    </siga:modal>   
    <siga:modal nome="terminarPendenciaModal" titulo="Terminar Pendência">
        <form action="${linkTo[SolicitacaoController].terminarPendencia}" method="post" onsubmit="javascript: return block();" enctype="multipart/form-data">
            <input type="hidden" name="todoOContexto" value="${todoOContexto}" />
            <input type="hidden" name="ocultas" value="${ocultas}" />
            <div style="display: inline" class="gt-form-row gt-width-66">
                <label>Descri&ccedil;&atilde;o</label>
                <textarea style="width: 100%" name="descricao" cols="50" rows="4"> </textarea>
            </div>
            <input
                type="hidden" name="idMovimentacao" id="movimentacaoId" value="" /><input
                type="hidden" name="motivo" id="motivoId" value="" /><input
                type="hidden" name="id" value="${solicitacao.id}" /> <input
                type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
        </form>
    </siga:modal>    
</siga:pagina>

<script language="javascript">
	function terminarPendencia(idMov) {
		$("#movimentacaoId").val(idMov);
		$("#terminarPendenciaModal_dialog").dialog("open");
	}

	function validarAssociacao(tipo) {
		$("#erroSolicitacao" + tipo).hide();
		$("#erroJustificativa" + tipo).hide();

		if ((tipo == 'Juncao' && $("#solicitacaoRecebeJuntadaSpan").html() == "")
				|| (tipo == 'Vinculo' && $("#solicitacaoRecebeVinculoSpan")
						.html() == "")) {
			$("#erroSolicitacao" + tipo).show();
			return false;
		}
		if ($("#justificativa" + tipo).val() == "") {
			$("#erroJustificativa" + tipo).show();
			return false;
		}
		return true;
	}

	function gravarAssociacao(tipo) {
		if (!block())
			return false;
		if (validarAssociacao(tipo)) {
			document.getElementById("formGravar" + tipo).submit();
		} else {
			unblock();
	    }
	}
	$('#checksolicitacao.fechadoAutomaticamente').change(
			function() {
				if (this.checked) {
					$('#checksolicitacao.fechadoAutomaticamente').prop('value',
							'true');
					return;
				}
				$('#checksolicitacao.fechadoAutomaticamente').prop('value',
						'false');
			});

	$(function() {
		$("#horario").mask("99:99");
		$("#horarioReplanejar").mask("99:99");
	});

	function postback() {
		var todoOContexto = ($("#todoOContexto").val() != null ? $(
				"#todoOContexto").val() : false);
		var ocultas = ($("#ocultas").val() != null ? $("#ocultas").val()
				: false);

		location.href = "${linkTo[SolicitacaoController].exibir[solicitacao.idSolicitacao]}?todoOContexto="
				+ todoOContexto + "&ocultas=" + ocultas;
	}

	$("#terminarPendenciaModal_dialog").dialog({
		autoOpen : false,
		height : 'auto',
		width : 'auto',
		modal : true,
		resizable : false
	});

	var MostradorHistorico = function(container, emptyMessage) {
		var url = container.find('ul'), intermediarios = url
				.find('li span:not(:first):not(:last)'), button = container
				.find('button'), me = this, TAMANHO_MAXIMO_DESCRICAO = 50;

		button.bind('click', function() {
			me.toogleItens();
		});

		this.toogleItens = function() {
			intermediarios.toggleClass('hidden');
			if (intermediarios.hasClass('hidden'))
				button.html('+');
			else {
				button.html('-');
			}
		}

		this.init = function() {
			this.adicionarMensagemSeVazio();
			this.verificarIntermediarios();
			this.formatarDescricoes();
			this.formatarLabel();
			container.removeClass('hidden');
		}

		this.verificarIntermediarios = function() {
			if (intermediarios.size() > 0) {
				this.toogleItens();
			} else {
				button.remove();
			}
		}

		this.formatarDescricoes = function() {
			url.find('li span').each(function() {
				var me = $(this), html = me.html();

				if (html.length > TAMANHO_MAXIMO_DESCRICAO) {
					me.attr('title', html);
					me.css('cursor', 'default');
					me.html(html.substr(0, TAMANHO_MAXIMO_DESCRICAO) + "...");
				}
			});
			url.find('li span:last').css('text-decoration', 'none');
		}

		this.adicionarMensagemSeVazio = function() {
			var lis = url.find('li');
			if (lis.size() == 0) {
				url.append('<li><span>' + emptyMessage + '</li></span>')
			}
		}

		this.formatarLabel = function() {
			if (container.find('ul li span').size() == 1) {
				container.prev('p').find('.historico-label').css('float',
						'left');
				container.find('ul li').addClass('unico');
			} else if (container.find('ul li span').size() > 2) {
				container.find('.lista-historico').css('margin-top', '-20px');
			}
		}
	}

	new MostradorHistorico($('.historico-item-container'), "Item não informado")
			.init();

	new MostradorHistorico($('.historico-acao-container'), "Ação não informada")
			.init();
</script>
