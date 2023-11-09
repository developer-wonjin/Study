package singleton;

public class Apps {
    public static void main(String[] args) {
        SettingsV1 settings1 = SettingsV1.getInstance();
        SettingsV1 settings2 = SettingsV1.getInstance();
        System.out.println(settings1 == settings2);

        SettingsV2 instance1 = SettingsV2.getInstance();
        SettingsV2 instance2 = SettingsV2.getInstance();

        System.out.println(instance1 == instance2);
    }
}
