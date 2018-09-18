#if (${PACKAGE_NAME} && ${PACKAGE_NAME} != "")package ${PACKAGE_NAME};#end
#parse("File Header.java")
public final class ${NAME}{
    private static ${NAME} ourInstance = new ${NAME}();

    public static ${NAME} getInstance() {
        return ourInstance;
    }

    private ${NAME}() {
    }
}
