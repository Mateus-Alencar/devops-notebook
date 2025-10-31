import yaml

if __name__ == "__main__":
    # "r" --> realiza a abertura do arquivo em modo leitura.
    stream = open("test.yaml", "r")
    # Carrega o conteúdo do YAML e converte para um dicionário Python.
    # safe_load é usado em vez de load para evitar execução de código malicioso dentro do YAML.
    dictionary = yaml.safe_load(stream)

    for key, value in dictionary.items():
        print(key + " : " + str(value))