/*
 * generated by Xtext 2.10.0
 */
package org.boomslang.dsl.mapping

import org.boomslang.dsl.mapping.services.ImportedNamespaceAwareLocalScopeProviderCustom
import com.google.inject.name.Names

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class MappingRuntimeModule extends AbstractMappingRuntimeModule {
	
	/**
	 * custom implicit imports
	 */
	override configureIScopeProviderDelegate(com.google.inject.Binder binder) {
		binder.bind(org.eclipse.xtext.scoping.IScopeProvider)
				.annotatedWith(
						Names.named(org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider.NAMED_DELEGATE))
				.to(ImportedNamespaceAwareLocalScopeProviderCustom);
	}
}
