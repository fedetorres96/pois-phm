package creacionales

import java.util.List
import poi.Local
import poi.Rubro
import poi.utils.Punto

class LocalBuilder {
	HorarioBuilder horario = new HorarioBuilder
	Local local = new Local => [rubro = new Rubro]

	def build() {
		local.horario = horario.build
		local.habilitado = true
		local
	}

	def radio(int nroCuadras) {
		local.rubro.radio = nroCuadras
		this
	}

	def horario(List<String> listaDias, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(listaDias, horAbre, minAbre, horCierra, minCierra)
		this
	}
	
	def domicilio(String _domicilio){
		local.domicilio = _domicilio
		this
	}

	def horario(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
		this
	}

	def ubicacion(double x, double y) {
		local.ubicacion = new Punto(x, y)
		this
	}

	def nombre(String _nombre) {
		local.nombre = _nombre
		this
	}

	def rubro(String _rubro) {
		local.rubro.nombre = _rubro
		this
	}
	
	def rubro(Rubro _rubro) {
		local.rubro = _rubro
		this
	}

	def clave(String palabra) {
		local.palabrasClave.add(palabra)
		this
	}
}