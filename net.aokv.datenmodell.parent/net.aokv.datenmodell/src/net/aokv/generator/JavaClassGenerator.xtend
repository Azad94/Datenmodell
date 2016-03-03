package net.aokv.generator

import net.aokv.datenmodell.Datendefinition
import net.aokv.datenmodell.Datenmodell
import net.aokv.datenmodell.Datennutzung
import org.eclipse.xtext.generator.IFileSystemAccess2
import net.aokv.datenmodell.Attribut
import net.aokv.datenmodell.Datentyp

class JavaClassGenerator implements AbstrakterGenerator {

	override generiereDatenmodell(Datenmodell datenmodell, IFileSystemAccess2 fsa) {
		datenmodell.elemente.forEach[it.generiereAbstraktesDatenmodellElement(fsa)]
	}

	def dispatch generiereAbstraktesDatenmodellElement(Datendefinition datendefinition, IFileSystemAccess2 fsa) {
		fsa.generateFile('''«datendefinition.name».java''', compile(datendefinition).toString)
	}

	def dispatch generiereAbstraktesDatenmodellElement(Datennutzung datennutzung, IFileSystemAccess2 fsa) {}


	val attributMapping = #{ Datentyp.TEXT -> "String", Datentyp.ZAHL -> "int" }
	def compile(Datendefinition datendefinition)
	'''
		public class «datendefinition.name»
		{
			«FOR attribut : datendefinition.attribute»
			«generiereAttribut(attribut)»
			«ENDFOR»
		}
	'''

	def generiereAttribut(Attribut attribut)
	{
		val datentyp = attributMapping.get(attribut.datentyp)
		val kleinerName = attribut.name.toLowerCase
		'''
		private «datentyp» «kleinerName»;

		public «datentyp» get«attribut.name»()
		{
			return «kleinerName»;
		}

		public void set«attribut.name»(«datentyp» «kleinerName»)
		{
			this.«kleinerName» = «kleinerName»;
		}
		'''
	}
	def generiereToString(Datendefinition datendefinition)
		'''
		@Override
		public String toString()
		{
			return String.format("Objekt %s { «datendefinition.attribute.map['''«it.name» = %s'''].join(", ")» }",
				"«datendefinition.name»",
				«datendefinition.attribute.map['''get«it.name»()'''].join(",\n")»
			);
		}
		'''
}
