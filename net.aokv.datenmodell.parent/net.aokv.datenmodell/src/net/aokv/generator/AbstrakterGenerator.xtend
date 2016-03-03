package net.aokv.generator

import org.eclipse.xtext.generator.IFileSystemAccess2
import net.aokv.datenmodell.Datenmodell

interface AbstrakterGenerator {
	def void generiereDatenmodell(Datenmodell datenmodell, IFileSystemAccess2 fsa)	
}