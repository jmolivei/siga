package br.gov.jfrj.siga.sr.model;

import java.util.Date;
import java.util.List;

import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import edu.emory.mathcs.backport.java.util.Arrays;

public class SrAtendimento extends SrEtapa {

	@Override
	public String getDescricao() {
		return "Atendimento (" + getLotaResponsavel().getSiglaCompleta() + ")";
	}
	
	
}
