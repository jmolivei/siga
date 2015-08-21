package br.gov.jfrj.siga.sr.model;

import java.util.Date;
import java.util.List;

import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import edu.emory.mathcs.backport.java.util.Arrays;

public class SrAtendimento extends SrEtapaSolicitacao {
	
	public SrAtendimento(SrSolicitacao sol, Date dtIni, Date dtFim, DpPessoa responsavel, DpLotacao lotaResponsavel) {
		super(sol);
		setInicio(dtIni);
		setFimEfetivo(dtFim);
		setResponsavel(responsavel);
		setLotaResponsavel(lotaResponsavel);
		setDescricao("Atendimento (" + getLotaResponsavel().getSiglaCompleta() + ")");
	}
}
