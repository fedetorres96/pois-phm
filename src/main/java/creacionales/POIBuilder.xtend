package creacionales

class POIBuilder {
	def banco() {
		new BancoBuilder
	}

	def cgp() {
		new CGPBuilder
	}

	def colectivo() {
		new ColectivoBuilder
	}

	def local() {
		new LocalBuilder
	}
}
