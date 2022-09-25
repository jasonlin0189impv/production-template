import numpy as np
import pandas as pd
from pydantic import BaseModel


class test(BaseModel):
    df = pd.DataFrame()
    array = np.zeros(5)


def test1(param_1, param_2) -> None:
    pass
