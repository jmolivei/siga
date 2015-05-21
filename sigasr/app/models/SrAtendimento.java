package models;

import java.text.SimpleDateFormat;
import java.util.Date;

import br.gov.jfrj.siga.dp.DpLotacao;


public class SrAtendimento implements Comparable<SrAtendimento> {

	private SrSolicitacao solicitacao;
	private Date dataInicio;
	private Date dataFinal;
	private SrValor tempoDecorrido;
	private SrFaixa faixa;
	private DpLotacao lotacaoAtendente;
	
	public SrSolicitacao getSolicitacao() {
		return solicitacao;
	}

	public Date getDataInicio() {
		return dataInicio;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public SrValor getTempoDecorrido() {
		return tempoDecorrido;
	}

	public SrFaixa getFaixa() {
		return faixa;
	}

	public DpLotacao getLotacaoAtendente() {
		return lotacaoAtendente;
	}	

	public void setSolicitacao(SrSolicitacao solicitacao) {
		this.solicitacao = solicitacao;
	}

	public void setDataInicio(Date dataInicio) {
		this.dataInicio = dataInicio;
	}

	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public void setTempoDecorrido(SrValor tempoDecorrido) {
		this.tempoDecorrido = tempoDecorrido;
	}

	public void setFaixa(SrFaixa faixa) {
		this.faixa = faixa;
	}

	public void setLotacaoAtendente(DpLotacao lotacaoAtendente) {
		this.lotacaoAtendente = lotacaoAtendente;
	}

	public String getDataInicioDDMMYYYYHHMMSS() {
		if (dataInicio != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			return df.format(dataInicio);
		}
		return "";
	}
	
	public String getDataFinalDDMMYYYYHHMMSS() {
		if (dataFinal != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			return df.format(dataFinal);
		}
		return "";
	}
	
	public enum SrFaixa {		
		ATE_1(1, "Ate 1 horas"), ATE_2(2, "Ate 2 horas"), ATE_4(3, "Ate 4 horas"), 
		ATE_8(4, "Ate 8 horas"), ATE_12(5, "Ate 12 horas"),ATE_16(6, "Ate 16 horas"), 
		ATE_24(7, "Ate 24 horas"), ACIMA_24(8, "Acima de 24 horas");
		
		public int idFaixa;
		public String descricao;
		
		private SrFaixa(int idFaixa, String descricao) {
			this.idFaixa = idFaixa;
			this.descricao = descricao;
		}
	}
	
	public SrFaixa definirFaixaDeHoras() {
		float horas = tempoDecorrido.getValorEmHora();
		if (horas <= 1)
			return SrFaixa.ATE_1;
		else if (horas > 1 && horas <= 2)
			return SrFaixa.ATE_2;
		else if (horas > 2 && horas <= 4)
			return SrFaixa.ATE_4;
		else if (horas > 4 && horas <= 8)
			return SrFaixa.ATE_8;
		else if (horas > 8 && horas <= 12)
			return SrFaixa.ATE_12;
		else if (horas > 12 && horas <= 16)
			return SrFaixa.ATE_16;
		else if (horas > 16 && horas <= 24)
			return SrFaixa.ATE_24;
		else
			return SrFaixa.ACIMA_24;
	}
	
	@Override
	public int compareTo(SrAtendimento o) {
		if (this != null && o != null) {
			if (this.getSolicitacao().codigo.equals(o.getSolicitacao().codigo))
				if (this.getDataInicio().equals(o.getDataInicio()))
					return this.getDataFinal().compareTo(o.getDataFinal());
				else 
					return this.getDataInicio().compareTo(o.getDataInicio());
			else
				return this.getSolicitacao().idSolicitacao.compareTo(o.getSolicitacao().idSolicitacao);
		}
		return 0;
	}
	
}