package poi.utils

import java.time.DayOfWeek
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Enumerated
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.LocalTime

@Accessors
@Entity
class RangoHorario {
	
	@Id
	@GeneratedValue
	private Long id
		
	@Enumerated(ORDINAL)
	DayOfWeek dia

	@Column
	LocalTime abre
	
	@Column
	LocalTime cierra

	def boolean estaDisponible(DateTime momento) {
		val diaMomento = DayOfWeek.of(momento.getDayOfWeek())
		val horaMomento = momento.toLocalTime()

		val coincideDia = dia == diaMomento
		val estaDentroRango = abre <= horaMomento && cierra >= horaMomento

		coincideDia && estaDentroRango
	}

	def RangoJSON asJson() {
		new RangoJSON(this)
	}

}

@Accessors
class RangoJSON {
	String abre
	String cierra

	new(RangoHorario rango) {
		abre = new DateTime().withDayOfWeek(rango.dia.value).withTime(rango.abre).toString
		cierra = new DateTime().withDayOfWeek(rango.dia.value).withTime(rango.cierra).toString
	}
}
