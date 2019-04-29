#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.context.annotation.Configuration;

#parse("File Header.java")

@Configuration
public class ${NAME} {
    //TODO Add bean producing methods using Allegro live templates
}
