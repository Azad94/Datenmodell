package net.aokv.generator

import net.aokv.datenmodell.Datenmodell
import net.aokv.datenmodell.Datennutzung
import org.eclipse.xtext.generator.IFileSystemAccess2
import java.util.HashMap
import java.util.Map

class MainGenerator implements AbstrakterGenerator {

	private Map<String, Integer> anzahlObjekte = new HashMap();

	override generiereDatenmodell(Datenmodell datenmodell, IFileSystemAccess2 fsa) {
		fsa.generateFile("Main.java", compile(datenmodell).toString)
	}

	def compile(Datenmodell datenmodell)
	{
		'''
		public class Main
		{
			public static void main(String[] args)
			{
				«FOR datennutzung: datenmodell.elemente.filter(Datennutzung)»
				«compile(datennutzung)»
				«ENDFOR»
			}
		}
		'''
	} 
	
	def compile(Datennutzung datennutzung)
	{
		val name = datennutzung.referenz.name
		val kleinerName = name.toLowerCase()
		anzahlObjekte.putIfAbsent(name, 1)
		val nummer = anzahlObjekte.get(name)
		val objektName = '''«kleinerName»«nummer»'''
		
		return '''
		«name» «objektName» = new «name»();
		«generiereSetterAufrufe(datennutzung, objektName)»
		System.out.println(«objektName»);
		'''
	}
	
	def generiereSetterAufrufe(Datennutzung datennutzung, CharSequence objektName) {
		return '''
		«FOR attributreferenz : datennutzung.referenzen»
			«objektName».set«attributreferenz.attribut.name»(«attributreferenz.wert»);
		«ENDFOR»
		'''
	}
	
}
