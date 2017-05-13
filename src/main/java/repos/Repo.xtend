package repos

import java.util.List

interface Repo<T> {
	
	def void save(T t)
	
	def void delete(T t) 

	def Class<T> getEntityType()
	
	def List<T> allInstances()
	
}