package repos.mongodb

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
}

