#if ($PACKAGE_NAME && $PACKAGE_NAME != "")package $PACKAGE_NAME;#end

import org.springframework.stereotype.Component;

#parse("File Header.java")

@Component
public class ${NAME} {

}
