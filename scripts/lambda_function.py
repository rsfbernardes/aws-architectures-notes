import json
import boto3
import os
from urllib.parse import unquote_plus

s3 = boto3.client('s3')

def lambda_handler(event, context):
    """
    Exemplo de handler:
    - Recebe evento S3 (PUT)
    - Lê objeto e copia para outro prefixo processed/
    """
    for record in event.get('Records', []):
        bucket = record['s3']['bucket']['name']
        key = unquote_plus(record['s3']['object']['key'])
        print(f"Processando {bucket}/{key}")

        dest_key = f"processed/{key}"

        try:
            # Copia objeto para processed/
            copy_source = {'Bucket': bucket, 'Key': key}
            s3.copy_object(Bucket=bucket, CopySource=copy_source, Key=dest_key)
            print(f"Copiado para {bucket}/{dest_key}")
        except Exception as e:
            print(f"Erro ao processar {key}: {e}")
            raise

    return {
        'statusCode': 200,
        'body': json.dumps('Processamento concluído.')
    }