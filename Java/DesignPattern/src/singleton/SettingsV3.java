package singleton;

public class SettingsV3 {

    /**
     * volatile 키워드를 써줘야 double checked locking이 동작함 (java 1.5 ~ )
      */
    private static volatile SettingsV3 instance;
    private SettingsV3() {}

    // double checked locking
    public SettingsV3 getInstance() {
        if (instance == null) {
            synchronized (SettingsV3.class) {
                if (instance == null) {
                    instance = new SettingsV3();
                }
            }
        }
        return instance;
    }
}
