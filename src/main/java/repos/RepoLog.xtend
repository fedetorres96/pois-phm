package repos

import poi.Log
import java.util.List

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

	override searchByExample(Log t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override defineUpdateOperations(Log t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}

