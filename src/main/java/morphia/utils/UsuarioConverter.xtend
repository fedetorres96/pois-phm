package morphia.utils

import org.mongodb.morphia.converters.TypeConverter
import org.mongodb.morphia.mapping.MappedField
import poi.Usuario
import com.mongodb.BasicDBObject
import repos.mysql.RepoUsuario

class UsuarioConverter extends TypeConverter {

	new() {
		super(Usuario)
	}

	override decode(Class<?> targetClass, Object fromDBObject, MappedField optionalExtraInfo) {
		val dbObject = fromDBObject as BasicDBObject

		val id = dbObject.getLong("id")

		RepoUsuario.instance.getById(id)
	}

	override encode(Object value, MappedField optionalExtraInfo) {
		val usuario = value as Usuario

		new BasicDBObject => [
			append("id", usuario.id)
			append("nombre", usuario.nombre)
		]
	}

}
