package repos

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

	def void cargaInicial() {
		val ale = new UsuarioBuilder().nombre("Ale").contrasenia("123").ubicacion(1, 2).build
		val favio = new UsuarioBuilder().nombre("Favio").contrasenia("123").ubicacion(2, 3).build
		val fede = new UsuarioBuilder().nombre("Fede").contrasenia("123").ubicacion(1, 3).build
		val javi = new UsuarioBuilder().nombre("Javi").contrasenia("123").ubicacion(2, 4).build
		val mauro = new UsuarioBuilder().nombre("Mauro").contrasenia("123").ubicacion(2, 2).build

		saveOrUpdate(ale)
		saveOrUpdate(favio)
		saveOrUpdate(fede)
		saveOrUpdate(javi)
		saveOrUpdate(mauro)
	}

}
