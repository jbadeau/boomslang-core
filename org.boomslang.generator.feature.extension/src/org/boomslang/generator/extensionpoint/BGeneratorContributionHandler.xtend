package org.boomslang.generator.extensionpoint

import org.boomslang.generator.interfaces.IBoomGenerator
import org.eclipse.core.runtime.IConfigurationElement
import org.eclipse.core.runtime.IExtensionRegistry
import org.eclipse.core.runtime.Platform
import org.eclipse.core.runtime.preferences.InstanceScope
import org.eclipse.ui.preferences.ScopedPreferenceStore

/** 
 * This class provides methods to get information about 
 * plugins that contribute to the extension point for custom generators.
 */
public class BGeneratorContributionHandler {

	public static final String IBOOMSLANGFEATUREGENERATOR_ID = "org.boomslang.generator.feature.support";
	public static final String IBOOMSLANGMAPPINGGENERATOR_ID = "org.boomslang.generator.mapping.support";	
	public static final String IBoomGeneratorAttributeName = "customGenerator"

	/** 
	 * @return a custom generator, if there is a plugin that contributes one via the
	 * extensionpoint  {@link #IBOOMSLANGFEATUREGENERATOR_ID}, {@code null} otherwise.
	 * 
	 * If there are multiple plugins contributing a generator, it returns the first generator found.
	 */
	def Class<? extends IBoomGenerator> getCustomFeatureGeneratorOrNull() {
		return getCustomGeneratorOrNull(IBOOMSLANGFEATUREGENERATOR_ID)
	}
	
    /** 
     * @return a custom generator, if there is a plugin that contributes one via the
     * extensionpoint  {@link #IBOOMSLANGMAPPINGGENERATOR_ID}, {@code null} otherwise.
     * 
     * If there are multiple plugins contributing a generator, it returns the first generator found.
     */
	def Class<? extends IBoomGenerator> getCustomMappingGeneratorOrNull() {
       return getCustomGeneratorOrNull(IBOOMSLANGMAPPINGGENERATOR_ID)
    }
    
    def private Class<? extends IBoomGenerator> getCustomGeneratorOrNull(String key) {
        val IExtensionRegistry registry = Platform.extensionRegistry
        val IConfigurationElement[] config = registry.getConfigurationElementsFor(key)
        
//        val ss = FeatureActivator.instance.preferenceStore
        
        val store = new ScopedPreferenceStore(InstanceScope.INSTANCE, "org.boomslang.dsl.feature.ui")
        val ss =  store.getString('generatorSwitch')
        val root = Platform.getPreferencesService().rootNode
        val prefs = InstanceScope.INSTANCE.getNode("org.boomslang.dsl.feature.Feature");
        val value = prefs.get('generatorSwitch', '')
//        Activator.getDefault().getPreferenceStore()
//                                .getString("MySTRING1");
//        val pref = Platform.getPreferencesService().getString("org.boomslang.dsl.feature.ui.preference.FeaturePreferencePage", 
//        											"generatorSwitch", "none", null)
        for (IConfigurationElement e : config) {
            val Object candidate = e.createExecutableExtension(IBoomGeneratorAttributeName);
            switch candidate {
                IBoomGenerator: return candidate.getClass()
            }
        }
        return null
    }
}
