package webapp

import org.uqbar.xtrest.api.XTRest
import repos.mysql.RepoPOI
import repos.mysql.RepoUsuario

class WebApplication {

	def static void main(String[] args) {

		val pois = RepoPOI.instance
		val usuarios = RepoUsuario.instance

		if (pois.allInstances.nullOrEmpty) {
			pois.cargaInicial
		}

		if (usuarios.allInstances.nullOrEmpty) {
			usuarios.cargaInicial
		}

		XTRest.start(POIController, 9000)

	}

}
