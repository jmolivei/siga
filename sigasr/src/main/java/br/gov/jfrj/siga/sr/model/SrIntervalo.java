package br.gov.jfrj.siga.sr.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class SrIntervalo {

	private Date inicio;

	private Date fim;

	private String descricao;

	public SrIntervalo(){
	}
	
	public SrIntervalo(Date dtIni){
		this(dtIni, null, null);
	}

	public SrIntervalo(Date dtIni, Date dtFim, String descr) {
		this.inicio = dtIni;
		this.fim = dtFim;
		this.descricao = descr;
	}

	public Date getInicio() {
		return inicio;
	}

	public SrIntervalo setInicio(Date dtIni) {
		this.inicio = dtIni;
		return this;
	}

	public Date getFim() {
		return fim;
	}

	public SrIntervalo setFim(Date dtFim) {
		this.fim = dtFim;
		return this;
	}
	
	public String getInicioString() {
		return toStr(getInicio());
	}

	public String getFimString() {
		return toStr(getFim());
	}

	public boolean isInfinita() {
		return fim == null;
	}

	public boolean terminouAntesDe(Date dt) {
		return fim != null && dt != null ? fim.before(dt) : false;
	}

	public boolean terminouDepoisDe(Date dt) {
		return fim != null && dt != null ? fim.after(dt) : false;
	}

	public boolean comecouAntesDe(Date dt) {
		return inicio != null && dt != null ? inicio.before(dt) : false;
	}

	public boolean comecouDepoisDe(Date dt) {
		return inicio != null && dt != null ? inicio.after(dt) : false;
	}
	
	public boolean abrange(Date dt){
		return !terminouAntesDe(dt) && !comecouDepoisDe(dt);
	}
	
	public boolean isFuturo(){
		return comecouDepoisDe(new Date());
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String toStr(Date dt) {
		return dt != null ? new SimpleDateFormat("dd/MM/yyyy HH:mm").format(dt)
				: "";
	}
	
	public Long segundos(Long millis){
		return millis != null ? millis / 1000 : null;
	}

	public Date getFimOuAgora() {
		return fim != null ? fim : new Date();
	}
	
	public Long getId(){
		return getInicio().getTime();
	}
	
}
