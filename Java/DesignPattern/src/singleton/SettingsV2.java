package singleton;

/**
 * 미리 인스턴스를 만들어놓음
 * 단점) 싱글톤객체를 만드는데 많은 리소스가 든다면 애플리케이션을 로딩하는 시점에 시간이 많이 걸림
 *      로딩시점에 시간이 많이 걸렸음에도 사용되지 않는다면 좀 아쉽다...ㅎㅎ
 */
public class SettingsV2 {

    private static final SettingsV2 INSTANCE = new SettingsV2();
    private SettingsV2() {}

    public static SettingsV2 getInstance() {
        return INSTANCE;
    }
}
