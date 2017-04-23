package creacionales

import java.time.DayOfWeek
import java.util.Map

final class DiasFactory {
	static Map<String, DayOfWeek> mapaDias = newHashMap
	(	"Lunes" -> DayOfWeek.MONDAY,
		"Martes" -> DayOfWeek.TUESDAY,
		"Miercoles" -> DayOfWeek.WEDNESDAY,
		"Jueves" -> DayOfWeek.THURSDAY,
		"Viernes" -> DayOfWeek.FRIDAY,
		"Sabado" -> DayOfWeek.SATURDAY ,
		"Domingo" -> DayOfWeek.SUNDAY	)
	
	private new(){}
	
	def static DayOfWeek toDayOfWeek(String nombreDia){
		mapaDias.get(nombreDia)
	}
	
}
