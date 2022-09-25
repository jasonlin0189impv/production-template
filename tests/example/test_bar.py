from src.example.bar import bar


def test_bar():
    # Given
    # When
    result = bar()

    # Then
    assert result == "How's it going"
