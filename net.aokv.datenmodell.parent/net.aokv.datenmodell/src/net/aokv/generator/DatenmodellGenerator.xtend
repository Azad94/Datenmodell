/*
 * generated by Xtext 2.9.0
 */
package net.aokv.generator

import net.aokv.datenmodell.Datenmodell
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DatenmodellGenerator extends AbstractGenerator {

	private val generatoren = #[new XmlGenerator(), new JavaClassGenerator(), new MainGenerator()]

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val datenmodelle = resource.allContents.filter(Datenmodell)
		datenmodelle.forEach [ datenmodell |
			generatoren.forEach [ generator |
				generator.generiereDatenmodell(datenmodell, fsa)
			]
		]
	}

}