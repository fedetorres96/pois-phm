package creacionales

import java.util.List
import poi.utils.Servicio

class ServicioBuilder {
	HorarioBuilder horario = new HorarioBuilder
	Servicio servicio = new Servicio

	def build() {
		servicio
	}

	def nombre(String _nombre) {
		servicio.nombre = _nombre
		this
	}
	
	def horario(List<String> nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
		servicio.horario = horario.build
		this
	}
	
	def horario(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
		servicio.horario = horario.build
		this
	}
}
