package repos.mongodb

import java.util.List
import poi.Log

class RepoLog extends RepoMongoDB<Log> {
	
	static RepoLog instance

	static def RepoLog getInstance() {
		instance ?: new RepoLog
	}
	
	private new() {
	}

	override getEntityType() {
		Log
	}
	
	def List<Log> getLogs(Log l) {
		ds.createQuery(entityType).field("l").equal(l.usuario).asList
	}
	
}

