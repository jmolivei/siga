package reports;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
import br.gov.jfrj.siga.cp.CpComplexo;

public class SrRelDadosBase extends RelatorioTemplate {

	public SrRelDadosBase(Map parametros) throws DJBuilderException {
		super(parametros);
		/*if (parametros.get("dtIni").equals("")) {
			throw new DJBuilderException(
					"Par√¢metro data inicial n√£o informado!");
		}
		if (parametros.get("dtFim").equals("")) {
			throw new DJBuilderException(
					"Par√¢metro data final n√£o informado!");
		}
		if (parametros.get("local") == null) {
			throw new DJBuilderException("Par√¢metro local n√£o informado!");
		}*/
}

	public AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, ColumnBuilderException {
		
		this.setTitle("RelatÛrio de Atendimentos");
		this.addColuna("SolicitaÁ„o", 30, RelatorioRapido.ESQUERDA, true);
		/*this.addColuna("Solicitante", 100, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Atendente", 30, RelatorioRapido.ESQUERDA, false);
		this.addColuna("Data de InÌcio", 30, RelatorioRapido.CENTRO, false);
		this.addColuna("Data de Fim", 30, RelatorioRapido.CENTRO, false);
		this.addColuna("Tempo de Atendimento", 30, RelatorioRapido.DIREITA, false);
		this.addColuna("Faixa", 30, RelatorioRapido.ESQUERDA, false);*/
		return this;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Collection processarDados() throws ParseException {

		//List<Object> d = new LinkedList<Object>();
		//String atendente = (String) parametros.get("atendente");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
			
		Query query = JPA.em().createQuery("select "
				+ "(select sol.codigo from SrSolicitacao sol where sol = s) from SrSolicitacao s inner join s.meuMovimentacaoSet mov "
				+ "where mov.tipoMov = 7 and mov.lotaAtendente.siglaLotacao = :lotaAtendente " 
				+ "and s.dtReg >= :dataIni and s.dtReg <= :dataFim");
		
		Date dtIni = formatter.parse((String) parametros.get("dtIni") + " 00:00:00");
		query.setParameter("dataIni", dtIni, TemporalType.TIMESTAMP);
		Date dtFim = formatter.parse((String) parametros.get("dtFim") + " 23:59:59");
		query.setParameter("dataFim", dtFim, TemporalType.TIMESTAMP);
		query.setParameter("lotaAtendente", parametros.get("atendente"));

		List<SrSolicitacao> lista = query.getResultList();
		return lista;
		//return d;
	}
		
}
