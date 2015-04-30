package models;

import java.util.Date;

import br.gov.jfrj.siga.dp.DpLotacao;


public class SrAtendimento  {

	private SrSolicitacao solicitacao;
	private Date dataInicioAtendimento;
	private Date dataFinalAtendimento;
	private SrFaixa faixa;
	private DpLotacao lotacaoAtendente;
	
		
	public SrSolicitacao getSolicitacao() {
		return solicitacao;
	}

	public void setSolicitacao(SrSolicitacao solicitacao) {
		this.solicitacao = solicitacao;
	}

	public Date getDataInicioAtendimento() {
		return dataInicioAtendimento;
	}

	public void setDataInicioAtendimento(Date dataInicioAtendimento) {
		this.dataInicioAtendimento = dataInicioAtendimento;
	}

	public Date getDataFinalAtendimento() {
		return dataFinalAtendimento;
	}

	public void setDataFinalAtendimento(Date dataFinalAtendimento) {
		this.dataFinalAtendimento = dataFinalAtendimento;
	}

	public SrFaixa getFaixa() {
		return faixa;
	}

	public void setFaixa(SrFaixa faixa) {
		this.faixa = faixa;
	}

	public DpLotacao getLotacaoAtendente() {
		return lotacaoAtendente;
	}

	public void setLotacaoAtendente(DpLotacao lotacaoAtendente) {
		this.lotacaoAtendente = lotacaoAtendente;
	}

	public enum SrFaixa {
		
		ATE_1(1, "Até 1 horas"), ATE_2(1, "Até 2 horas"), ATE_4(1, "Até 4 horas"), ATE_8(1, "Até 8 horas"),
		ATE_12(1, "Até 12 horas"),ATE_16(1, "Até 16 horas"), ATE_24(1, "Até 24 horas");
		
		public int idFaixa;
		public String descricao;
		
		private SrFaixa(int idFaixa, String descricao) {
			this.idFaixa = idFaixa;
			this.descricao = descricao;
		}
	}
	
}