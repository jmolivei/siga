package reports;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.Query;
import javax.persistence.TemporalType;

import models.SrAcao;
import models.SrAtendimento;
import models.SrItemConfiguracao;
import models.SrSolicitacao;


import play.db.jpa.JPA;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.DJBuilderException;
import br.gov.jfrj.relatorio.dinamico.AbstractRelatorioBaseBuilder;
import br.gov.jfrj.relatorio.dinamico.RelatorioRapido;
import br.gov.jfrj.relatorio.dinamico.RelatorioTemplate;
import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.cp.CpComplexo;

public class SrRelDadosBase extends RelatorioTemplate {

	public SrRelDadosBase(Map parametros) throws DJBuilderException {
		super(parametros);
		/*if (parametros.get("dtIni").equals("")) {
			throw new DJBuilderException(
					"Parâmetro data inicial não informado!");
		}
		if (parametros.get("dtFim").equals("")) {
			throw new DJBuilderException(
					"Parâmetro data final não informado!");
		}
		if (parametros.get("local") == null) {
			throw new DJBuilderException("Parâmetro local não informado!");
		}*/
}

	public AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, ColumnBuilderException {
		
		this.setTitle("Relatorio de Atendimentos");
		this.addColuna("Solicitacao", 30, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Data de Abertura", 25, RelatorioRapido.CENTRO, false);
		//this.addColuna("Solicitante", 50, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Atendente", 20, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Data de Inicio Atendimento", 25, RelatorioRapido.CENTRO, false);
		this.addColuna("Data de Fim Atendimento", 25, RelatorioRapido.CENTRO, false);
		this.addColuna("Tempo de Atendimento", 40, RelatorioRapido.DIREITA, false);
		this.addColuna("Faixa", 20, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Fechada?", 15, RelatorioRapido.ESQUERDA, false);
		return this;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Collection processarDados() throws ParseException {
		List<String> listaFinal = new LinkedList<String>();
		Set<SrAtendimento> listaAtendimento = null;
		DateFormat formatter = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		
		//movimentacao de inicio de atendimento (tipo = 1), fechamento (tipo = 7), escalonamento (tipo = 24)  
		Query query = JPA.em().createQuery("select sol from SrSolicitacao sol where sol.idSolicitacao in ("
				+ "select s.idSolicitacao from SrSolicitacao s inner join s.meuMovimentacaoSet mov "
				+ "where (mov.tipoMov = 1 or mov.tipoMov = 7 or mov.tipoMov = 24) and mov.lotaAtendente.siglaLotacao = :lotaAtendente " 
				+ "and s.dtReg >= :dataIni and s.dtReg <= :dataFim group by s.idSolicitacao) "
				+ "order by sol.dtReg");
		
		//Query query = JPA.em().createQuery("select s from SrSolicitacao s where s.codigo = 'TRF2-SR-2015/05282'"); //TRF2-SR-2015/05282, TRF2-SR-2015/05228, TRF2-SR-2015/05780
				
		Date dtIni = formatter.parse((String) parametros.get("dtIni") + " 00:00:00");
		query.setParameter("dataIni", dtIni, TemporalType.TIMESTAMP);
		Date dtFim = formatter.parse((String) parametros.get("dtFim") + " 23:59:59");
		query.setParameter("dataFim", dtFim, TemporalType.TIMESTAMP);
		query.setParameter("lotaAtendente", parametros.get("atendente"));

		List<SrSolicitacao> lista = query.getResultList();
		for (SrSolicitacao sol : lista) {
			if (sol.isCancelado())
				continue;
			listaAtendimento = sol.getAtendimentosSolicitacaoPai();
			//listaAtendimento = sol.getAtendimentos(false);
			for (SrAtendimento atendimento : listaAtendimento) {
				if (atendimento.getLotacaoAtendente().getSigla().equals(parametros.get("atendente"))) {
					listaFinal.add(sol.codigo);
					listaFinal.add(sol.getDtRegDDMMYYYYHHMM());
					//listaFinal.add(sol.solicitante.getNomePessoaAI());
					//listaFinal.add(sol.solicitante.getNomePessoaAI() + " - " + sol.solicitante.getSigla());
					listaFinal.add(atendimento.getLotacaoAtendente().getSiglaCompleta());
					listaFinal.add(atendimento.getDataInicioDDMMYYYYHHMMSS());
					listaFinal.add(atendimento.getDataFinalDDMMYYYYHHMMSS());
					listaFinal.add(atendimento.getTempoDecorrido().toString());
					listaFinal.add(atendimento.definirFaixaDeHoras().descricao);
					listaFinal.add(sol.isFechado() ? "Sim" : "Nao" );
				}
			}
		}
		return listaFinal;
	}
		
}