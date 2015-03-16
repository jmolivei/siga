package siga.siga_jsf2_module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import br.gov.jfrj.siga.libs.design.Menu;
import br.gov.jfrj.siga.libs.design.SigaDesign;
import br.gov.jfrj.siga.libs.design.Substituicao;

@ManagedBean
@RequestScoped
public class HelloWorld {
	private final String text = "Hello, World!";

	private String letters;

	private String numbers;

	private String email;

	public HelloWorld() {
	}

	@PostConstruct
	public void initialize() {
		System.out
				.println(this.getClass().getSimpleName() + " was constructed");
	}

	public String getText() {
		return text;
	}

	@NotNull
	@NotEmpty
	@Pattern(regexp = "[A-Za-z]*", message = "must contain only letters")
	public String getLetters() {
		return letters;
	}

	public void setLetters(String letters) {
		this.letters = letters;
	}

	@NotNull
	@NotEmpty
	@Digits(fraction = 0, integer = 2)
	public String getNumbers() {
		return numbers;
	}

	public void setNumbers(String numbers) {
		this.numbers = numbers;
	}

	@NotNull
	@NotEmpty
	@Email
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCabecalho() {

		Map<String, Boolean> permissoes = new HashMap();
		List<Menu> menus = new Menu.MenuBuilder()
		.menu("sitemap", "Cadastro", null, true)

		.item("cube", "Documentos",
				"/siga/app/expediente/doc/listar?primeiraVez=sim",
				"SIGA;DOC:Módulo de Documentos")

		.build();
		
		List<Substituicao> substituicoes = new ArrayList();

		return SigaDesign.cabecalho("titulo da página", "ambiente", null, null,
				null, false, false, false, "JOHN DOE", "SESIA", "JANE DOE",
				"CSIS", permissoes, menus, substituicoes, null);
	}

	public String getCabecalhoHead() {
		String s = getCabecalho();
		s = s.substring(s.indexOf("<head>") + 6);
		s = s.substring(0, s.indexOf("</head>"));

		return s;
	}

	public String getCabecalhoBody() {
		String s = getCabecalho();
		int iBody = s.indexOf("<body");
		s = s.substring(s.indexOf(">", iBody) + 1);

		return s;
	}

	public String getRodapeBody() {
		String s = SigaDesign.rodape(false, false);
		s = s.substring(0, s.indexOf("</body>"));
		return s;
	}
}
