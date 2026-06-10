import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")

    val fixAndroidProject = Action<Project> {
        if (hasProperty("android")) {
            val android = extensions.getByName("android")
            if (android is com.android.build.gradle.BaseExtension) {
                // 1. Fix "Namespace not specified"
                if (android.namespace == null) {
                    android.namespace = "com.pobitra.pobitra_browser.${name.replace("-", "_")}"
                }

                // 2. Fix "Setting the namespace via the package attribute... is no longer supported"
                val manifestFile = file("src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    try {
                        val content = manifestFile.readText()
                        if (content.contains("package=")) {
                            val updatedContent = content.replace(Regex("""package="[^"]*""""), "")
                            if (content != updatedContent) {
                                manifestFile.writeText(updatedContent)
                            }
                        }
                    } catch (e: Exception) {
                        // Silent ignore
                    }
                }
            }
        }
    }

    if (state.executed) {
        fixAndroidProject.execute(project)
    } else {
        afterEvaluate {
            fixAndroidProject.execute(project)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
