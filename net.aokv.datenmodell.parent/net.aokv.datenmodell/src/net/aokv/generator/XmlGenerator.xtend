package net.aokv.generator

import net.aokv.datenmodell.Attributsreferenz
import net.aokv.datenmodell.Datendefinition
import net.aokv.datenmodell.Datenmodell
import net.aokv.datenmodell.Datennutzung
import org.eclipse.xtext.generator.IFileSystemAccess2

class XmlGenerator implements AbstrakterGenerator {

	override generiereDatenmodell(Datenmodell datenmodell, IFileSystemAccess2 fsa) {
		datenmodell.elemente.forEach[it.generiereAbstraktesDatenmodellElement(fsa)]
	}

	def dispatch generiereAbstraktesDatenmodellElement(Datendefinition datenmodell, IFileSystemAccess2 fsa) {}

	def dispatch generiereAbstraktesDatenmodellElement(Datennutzung nutzung, IFileSystemAccess2 fsa) {
		fsa.generateFile('''«nutzung.referenz.name».xml''', compile(nutzung))
	}

	def private compile(Datennutzung datennutzung) '''
		<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
		<«datennutzung.referenz.name»>
			«FOR attribut : datennutzung.referenzen»«generiere(attribut)»«ENDFOR»
		</«datennutzung.referenz.name»>
	'''
	
	def generiere(Attributsreferenz attributsreferenz) 
	'''<«attributsreferenz.attribut.name»>«attributsreferenz.wert»</«attributsreferenz.attribut.name»>'''
	
}
