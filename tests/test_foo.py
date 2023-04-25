from src.foo import foo


def test_foo():
    # Given
    # When
    result = foo()
    
    # Then
    assert result == "hello world"
