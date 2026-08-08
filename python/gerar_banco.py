# %%
import pandas as pd
import sqlite3
from pathlib import Path

# %%
# ==========================================
# Caminhos
# ==========================================

# Ler CSV

df = pd.read_csv("Student_Performance/student_performance_dataset.csv")

# %%
# Conferir os tipos

print(df.dtypes)

# %%
# Caminho do banco SQLite

DB = "Student_Performance/estudantes.db"

# %%
# Criar banco SQLite

with sqlite3.connect(DB) as conn:
    df.to_sql(
        "estudantes",
        conn,
        if_exists="replace",
        index=False
    )

print("Banco criado com sucesso!")