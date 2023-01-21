# Remote Authentication Use Case

> ## Caso de sucesso (OK - 200)
1. ✅ Sistema valida os dados
2. ✅ Sistema faz uma requisição para a URL da API de login

> ## Exceção - Dados inválidos (Bad Request - 400)
3. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Email em uso (Forbidden - 403)
4. ✅ Sistema retorna uma mensagem de erro informando que o email já está em uso

> ## Exceção - URL inválida (Not Found - 404)
5. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor (Internal Server Error - 500)
6. ✅ Sistema retorna uma mensagem de erro inesperado
