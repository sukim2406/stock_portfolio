FROM python:3.9.0

WORKDIR /home/

RUN echo "I think it will work now"

RUN git clone https://github.com/sukim2406/stock_portfolio.git

WORKDIR /home/stock_portfolio/

RUN pip install -r requirements.txt 

RUN pip install gunicorn 

RUN pip install mysqlclient

WORKDIR /home/stock_portfolio/stock_portfolio_backend/

EXPOSE 8000

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=stock_portfolio_backend.settings.deploy && python manage.py migrate --settings=stock_portfolio_backend.settings.deploy && gunicorn stock_portfolio_backend.wsgi --env DJANGO_SETTINGS_MODULE=stock_portfolio_backend.settings.deploy --bind 0.0.0.0:8000"]