package creacionales

import java.time.DayOfWeek
import java.util.List
import org.joda.time.LocalTime
import poi.utils.RangoHorario

import static extension creacionales.DiasFactory.*

class HorarioBuilder {
	List<RangoHorario> horario = newArrayList

	def build() {
		horario
	}

	def dia(List<String> listaDias, int horAbre, int minAbre, int horCierra, int minCierra) {
		
		listaDias.forEach[nombreDia|dia(nombreDia, horAbre, minAbre, horCierra, minCierra)]
		this
	}

	def dia(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		val dayOfWeek = nombreDia.toDayOfWeek
		val rango = crearRango( dayOfWeek, horAbre, minAbre,horCierra, minCierra )
		horario.add( rango )
		this
	}

	def crearRango(DayOfWeek _dia, int horAbre, int minAbre, int horCierra, int minCierra) {
		new RangoHorario => [
			dia = _dia
			abre = new LocalTime(horAbre, minAbre)
			cierra = new LocalTime(horCierra, minCierra)
		]
	}

}
