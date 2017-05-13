package repos.mysql

import creacionales.UsuarioBuilder
import poi.Usuario

class RepoUsuario extends RepoMySQL<Usuario> {

	static RepoUsuario instance

	static def RepoUsuario getInstance() {
		instance ?: new RepoUsuario
	}

	private new() {
	}

	override getEntityType() {
		Usuario
	}

	def Usuario getUsuario(String _nombre, String _contrasenia) {
		allInstances.findFirst[nombre.equals(_nombre) && contrasenia.equals(_contrasenia)]
	}

	def void cargaInicial() {
		val ale = new UsuarioBuilder().nombre("Ale").contrasenia("123").ubicacion(1, 2).build
		val favio = new UsuarioBuilder().nombre("Favio").contrasenia("123").ubicacion(2, 3).build
		val fede = new UsuarioBuilder().nombre("Fede").contrasenia("123").ubicacion(1, 3).build
		val javi = new UsuarioBuilder().nombre("Javi").contrasenia("123").ubicacion(2, 4).build
		val mauro = new UsuarioBuilder().nombre("Mauro").contrasenia("123").ubicacion(2, 2).build

		save(ale)
		save(favio)
		save(fede)
		save(javi)
		save(mauro)
	}

}
