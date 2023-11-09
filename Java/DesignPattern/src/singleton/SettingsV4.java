package singleton;

/**
 * double checked locking 을 더 개선한 버전
 * static inner클래스 이용하기
 */
public class SettingsV4 {

    private SettingsV4() {}

    private static class SettingsHolder {
        private static final SettingsV4 INSTANCE = new SettingsV4();
    }

    /**
     * getInstance() 호출될 때 Inner클래스가 로딩이 되고 static변수를 만들기 때문에
     * 호출시점(LazyLoading)에 싱글톤객체를 만들수 있으면서도
     * 멀티스레드에 안전하다
     * @return
     */
    public SettingsV4 getInstance() {
        return SettingsHolder.INSTANCE;
    }
}
