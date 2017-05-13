package repos.mongodb

import com.mongodb.MongoClient
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import poi.Log
import poi.Opinion
import repos.Repo

abstract class RepoMongoDB<T> implements Repo<T>{
	
	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			
			morphia = new Morphia => [
				
				map(Opinion).
				map(Log)
				
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
			
			println("Conectado a MongoDB. Bases en MongoDB: " + ds.getDB.collectionNames)
		}
	}
	
	override save(T t) {
		ds.save(t)
	}
	
	override delete(T t) {
		ds.delete(t)
	}

	override allInstances() {
		ds.createQuery(entityType).asList
	}

}
