package morphia.utils

import com.mongodb.BasicDBObject
import org.mongodb.morphia.converters.TypeConverter
import org.mongodb.morphia.mapping.MappedField
import poi.POI
import repos.mysql.RepoPOI

class POIConverter extends TypeConverter {

	new() {
		super(POI)
	}

	override decode(Class<?> targetClass, Object fromDBObject, MappedField optionalExtraInfo) {
		val dbObject = fromDBObject as BasicDBObject

		val id = dbObject.getLong("id")

		return RepoPOI.instance.getById(id)
	}

	override encode(Object value, MappedField optionalExtraInfo) {
		val poi = value as POI

		new BasicDBObject => [
			append("id", poi.id)
			append("nombre", poi.nombre)
		]
	}

}
