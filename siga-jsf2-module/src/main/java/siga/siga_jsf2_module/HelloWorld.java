package siga.siga_jsf2_module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import br.gov.jfrj.siga.libs.design.Menu;
import br.gov.jfrj.siga.libs.design.SigaDesign;
import br.gov.jfrj.siga.libs.design.Substituicao;

@ManagedBean
@SessionScoped
public class HelloWorld {
	private final String text = "Hello, World!";

	private String pagina;

	private String letters;

	private String numbers;

	private String email;

	public HelloWorld() {
	}

	@PostConstruct
	public void initialize() {
		Map<String, Boolean> permissoes = new HashMap();
		List<Menu> menus = new Menu.MenuBuilder()
				.menu("sitemap", "Cadastro", null, true)

				.item("cube", "Documentos", "#",
						"SIGA;DOC:Módulo de Documentos")

				.build();

		List<Substituicao> substituicoes = new ArrayList();

		this.pagina = SigaDesign.pagina("titulo da página", "ambiente", null,
				null, null, false, false, false, "JOHN DOE", "SESIA",
				"JANE DOE", "CSIS", permissoes, menus, substituicoes, null);

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

	public String getCabecalhoHead() {
		return SigaDesign.cabecalhoHead(pagina);
	}

	public String getCabecalhoBody() {
		return SigaDesign.cabecalhoBody(pagina);
	}

	public String getRodapeBody() {
		return SigaDesign.rodapeBody(pagina);
	}

	public String teste() {

		System.out.println();
		return null;
	}

}
