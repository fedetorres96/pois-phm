package poi.utils

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

@Accessors
class Poligono {
	static List<Punto> surface = newArrayList

	private def static List<Point> getPoints() {
		surface.map[point]
	}

	private def static Polygon getPolygon() {
		new Polygon(getPoints())
	}

	def static boolean isInside(List<Punto> puntos, Punto punto) {
		surface = puntos
		polygon.isInside(punto.point)
	}
}
